const express = require('express')
const cors = require('cors')
const axios = require('axios')
const app = express()
const port = 3000
app.use(cors())
app.use(express.json())
const connection = require('../Connection/conn')
app.post("/getFeed", async (req, res) => {
    try {
        const rows = await new Promise((resolve, reject) => {
            connection.query("select * from User", (err, rows) => {
                if (err) return reject(err);
                resolve(rows);
            });
        });
        const possibleConnectionsList = await possibleConnections(req.body.userId);
        var possibleConnectionsUserIds = []
        var connectionText = []
        var percentages = []
        for(let data of possibleConnectionsList){
            possibleConnectionsUserIds.push(data.userId)
            connectionText.push(data.text)
            percentages.push(data.percentage)
        }
        var data = {
            "userIds": possibleConnectionsUserIds
        }
        var response = await axios.post("http://localhost:3000/getUserById", data)
        var feedData = response.data
        for(var i in feedData){
            feedData[i].text = connectionText[i]
            feedData[i].percentage = percentages[i]
        }
        res.send(200, feedData);
    } catch (err) {
        console.error(err);
        res.send(500, "An error occurred while processing the request.");
    }
});
app.post("/getUserById", (req, res) => {
    var userIds = req.body.userIds
    connection.query("select * from user where userId in (?)", [userIds], (err, result) => {
        if (err) throw err
        res.send(200, result)
    })
})
app.post("/createUser", (req,res)=>{
    connection.query(`insert into user(userName, email, phoneNo, age, gender, sentLikes, recievedLikes, connections) values('${req.body.username}', '${req.body.email}', '${req.body.phoneNo}', '${req.body.age}', '${req.body.gender}', '', '', '')`, (err) => {
        if (err) throw err
        res.send(200, "ok");
    })
})
app.post("/addGenreArtist", (req, res) => {
    var genres = req.body.genres;
    var artists = req.body.artists;
    var genresString = genres.join(', ') + ', ';
    var artistsString = artists.join(', ') + ', ';

    connection.query("select userId from user", (err, result) => {
        if (err) throw err;
        if (result.length > 0) {
            var userId = result[0].userId;
            connection.query(`insert into userPreference(userId, genres, artists) values(${userId}, '${genresString}', '${artistsString}')`, (err) => {
                if (err) throw err;
                res.status(200).send("ok");
            });
        } else {
            res.status(404).send("User not found");
        }
    });
});
app.post("/addLike", (req, res) => {
    connection.query(`update user set sentLikes = concat(sentLikes, '${req.body.userId}, ') where userId = ${req.body.currentUserId}`, (err) => {
        if (err) throw err
        res.send(200, "ok")
    })
})
app.post("/getCurrentUserId", (req, res) => {
    connection.query(`select userId from user where phoneNo = '${req.body.phoneNo}'`, (err, result) => {
        if (err) throw err
        res.send(200, result)
    })
})
app.listen(port, () => {
    console.log(`Successfully listening on port ${port}`)
})
function possibleConnections(currentUserId){
    return new Promise((resolve, reject) => {
        var currentUser
        var otherUsers = []
        var currentUserPreference
        console.log(currentUserId)
        connection.query("select * from userPreference", (err, result) => {
            if (err) throw err
            for(let res of result){
                if(res.userId == currentUserId){
                    currentUserPreference = res
                }
            }
        })
        connection.query(`select * from user`, (err, result) => {
            if (err) throw err
            for(let res of result){
                if(res.userId == currentUserId){
                    currentUser = res
                }
                else{
                    otherUsers.push(res)
                }
            }
            console.log(currentUser)
            var existingLikesString = currentUser.sentLikes || ''
            var existingConnectionsString = currentUser.connections || ''
            var recievedLikesString = currentUser.recievedLikes || ''
            var possibleConnectionsList = []
            if(existingLikesString!='' && existingConnectionsString!='' && recievedLikesString!=''){
                var existingLikes = existingLikesString.split(", ")
                var existingConnections = existingConnectionsString.split(", ")
                var recievedLikes = recievedLikesString.split(", ")
                for(var i=0; i<otherUsers.length; i++){
                    if((otherUsers[i].userId in existingLikes) || (otherUsers[i].userId in existingConnections) || (otherUsers[i].userId in recievedLikes)){
                        continue
                    }
                    else{
                        possibleConnectionsList.push(otherUsers[i].userId)
                    }
                }
            }
            else{
                possibleConnectionsList = otherUsers
            }
            var possibleConnectionsList = checkMusicTaste(currentUserPreference.genres, currentUserPreference.artists, possibleConnectionsList)
            resolve(possibleConnectionsList)
        })
    })
}
function checkMusicTaste(currentUserGenres, currentUserArtists, otherUsers) {
    var currentUserGenresList = currentUserGenres.split(", ");
    var currentUserArtistsList = currentUserArtists.split(", ");
    var userMusicTasteMatch = [];

    for (let user of otherUsers) {
        var otherUserGenresList = user.genres.split(", ");
        var otherUserArtistsList = user.artists.split(", ");

        var commonGenres = [];
        var commonArtists = [];

        var commonGenresString = ''
        var commonArtistsString = ''

        var artistText = '';
        var percentage = 3;

        for (let genre of otherUserGenresList) {
            if (currentUserGenresList.includes(genre)) {
                commonGenres.push(genre);
                commonGenresString = commonGenresString + " " + genre
            }
        }

        for (let artist of otherUserArtistsList) {
            if (currentUserArtistsList.includes(artist)) {
                commonArtists.push(artist);
                commonArtistsString = commonArtistsString + " " + artist
            }
        }
        if (commonGenres.length > 0 || commonArtists.length > 0) {
            // Calculate percentage based on the new equation
            let genrePercentage = (commonGenres.length / 3) * 30; // 30% weight for genres
            let artistPercentage = (commonArtists.length / 9) * 70; // 70% weight for artists
        
            let percentage = genrePercentage + artistPercentage;
        
            // Form genre text
            let genreText = '';
            if (commonGenres.length === 1) {
                genreText = ` ${commonGenres[0]} music`;
            } else if (commonGenres.length === 2) {
                genreText = ` ${commonGenres[0]} and ${commonGenres[1]} music`;
            } else if (commonGenres.length > 2) {
                genreText = ` ${commonGenres.slice(0, -1).join(', ')}, and ${commonGenres[commonGenres.length - 1]} music`;
            }
        
            // Form artist text
            let artistText = '';
            if (commonArtists.length > 0) {
                artistText = ` and have common favourite artists ${commonArtists.join(', ')}`;
            }
        
            // Push result
            userMusicTasteMatch.push({
                "text": `You both listen to${genreText}${artistText}`,
                "percentage": percentage,
                "userId": user.userId
            });
        }
    }
    return userMusicTasteMatch;
}