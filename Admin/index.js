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
                console.log(jsonData['age'])
                const userDataDiv = document.getElementById("data");
                if (userDataDiv) {
                    const userData = `<p>Name: ${jsonData.userName}</p><p>Age: ${jsonData.age}</p><p>Gender: ${jsonData.gender}</p>`;
                    userDataDiv.innerHTML = userData;
                } else {
                    console.error('Element with ID "data" not found.');
                }
                const userName = document.getElementById("userName");
                const age = document.getElementById("age");
                const gender = document.getElementById("gender");
                userName.innerHTML = jsonData.userName;
                age.innerHTML = jsonData.age;
                gender.innerHTML = jsonData.gender
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
