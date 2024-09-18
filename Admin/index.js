console.log("Script loaded");
document.addEventListener("DOMContentLoaded", function() {
    function getUsers(){
        fetch("http://localhost:3000/User")
            .then((response) => {
                if (!response.ok) {
                    throw new Error("Network response was not ok");
                }
                return response.json();
            })
            .then((data) => {
                const jsonData = data;
                console.log(jsonData)
                const userDataDiv = document.getElementById("data");
                const table1 = document.getElementById("table1");
                table1.style.display = "table";
                /*if (userDataDiv) {
                    const userData = `<p>Name: ${jsonData.userName}</p><p>Age: ${jsonData.age}</p><p>Gender: ${jsonData.gender}</p>`;
                    userDataDiv.innerHTML = userData;
                } else {
                    console.error('Element with ID "data" not found.');
                }*/
                const userName0 = document.getElementById("userName0");
                const age0 = document.getElementById("age0");
                const gender0 = document.getElementById("gender0");
                const userName1 = document.getElementById("userName1");
                const age1 = document.getElementById("age1");
                const gender1 = document.getElementById("gender1");
                const userName2 = document.getElementById("userName2");
                const age2 = document.getElementById("age2");
                const gender2 = document.getElementById("gender2");
                const userName3 = document.getElementById("userName3");
                const age3 = document.getElementById("age3");
                const gender3 = document.getElementById("gender3");
                const userName4 = document.getElementById("userName4");
                const age4 = document.getElementById("age4");
                const gender4 = document.getElementById("gender4");
                userName0.innerHTML = jsonData[0].userName;
                age0.innerHTML = jsonData[0].age;
                gender0.innerHTML = jsonData[0].gender
                userName1.innerHTML = jsonData[1].userName;
                age1.innerHTML = jsonData[1].age;
                gender1.innerHTML = jsonData[1].gender
                userName2.innerHTML = jsonData[2].userName;
                age2.innerHTML = jsonData[2].age;
                gender2.innerHTML = jsonData[2].gender
                userName3.innerHTML = jsonData[3].userName;
                age3.innerHTML = jsonData[3].age;
                gender3.innerHTML = jsonData[3].gender
                userName4.innerHTML = jsonData[4].userName;
                age4.innerHTML = jsonData[4].age;
                gender4.innerHTML = jsonData[4].gender
                // Use template literals correctly
                //const userData = `<p>Name: ${jsonData.userName}</p><p>Age: ${jsonData.age}</p><p>Gender: ${jsonData.gender}</p>`;
                //userDataDiv.innerHTML = userData;
            })
            .catch((error) => {
                console.error('Error fetching data:', error);
            });
    }

    // Expose getUsers to the global scope
    window.getUsers = getUsers;
});
