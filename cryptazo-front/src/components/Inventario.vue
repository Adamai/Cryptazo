<template>
    <div id="zombies"></div>
</template>

<script>
    require('./../../public/cryptazo_abi')

    var cryptoZombies;
    var userAccount;

    function startApp() {
        var cryptoZombiesAddress = "YOUR_CONTRACT_ADDRESS";
        cryptoZombies = new web3js.eth.Contract(cryptazo_abi, cryptoZombiesAddress);

        var accountInterval = setInterval(function() {
            // Check if account has changed
            if (web3.eth.accounts[0] !== userAccount) {
                userAccount = web3.eth.accounts[0];
                // Call a function to update the UI with the new account
                getZombiesByOwner(userAccount)
                    .then(displayZombies);
            }
        }, 100);
    }

    function displayZombies(ids) {
        $("#zombies").empty();
        for (id of ids) {
            // Look up zombie details from our contract. Returns a `zombie` object
            getZombieDetails(id)
                .then(function(zombie) {
                    // Using ES6's "template literals" to inject variables into the HTML.
                    // Append each one to our #zombies div
                    $("#zombies").append(`<div class="zombie">
              <ul>
                <li>Name: ${zombie.name}</li>
                <li>DNA: ${zombie.dna}</li>
                <li>Level: ${zombie.level}</li>
                <li>Wins: ${zombie.winCount}</li>
                <li>Losses: ${zombie.lossCount}</li>
                <li>Ready Time: ${zombie.readyTime}</li>
              </ul>
            </div>`);
                });
        }
    }

    // Start here

    function getZombieDetails(id) {
        return cryptoZombies.methods.tazos(id).call()
    }

    function zombieToOwner(id) {
        return cryptoZombies.methods.tazoToOwner(id).call()
    }

    function getZombiesByOwner(owner) {
        return cryptoZombies.methods.getTazosByOwner(owner).call()
    }

    window.addEventListener('load', function() {

        // Checking if Web3 has been injected by the browser (Mist/MetaMask)
        if (typeof web3 !== 'undefined') {
            // Use Mist/MetaMask's provider
            web3js = new Web3(web3.currentProvider);
        } else {
            // Handle the case where the user doesn't have Metamask installed
            // Probably show them a message prompting them to install Metamask
        }

        // Now you can start your app & access web3 freely:
        startApp()

    })

export default {
  name: 'HelloWorld',
  props: {
    msg: String
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
