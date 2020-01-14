<style>

#globe {
    background: url('/static/globe.jpeg');
    width: 400px;
    height: 100%;
    background-size: cover;
    margin: 0px;
    border-radius: 0px 10px 10px 0px;
}

#war {
    background: url('/static/war.jpeg');
    transform: scale(1.0);
    width: 500px;
    height: 100%;
    background-size: cover;
    background-position: center;
    margin: 0px;
    border-radius: 10px 0px 0px 10px;
    filter: brightness(70%);
}

#attack {
    background: url('/static/attack.jpg');
    width: 400px;
    height: 100%;
    background-size: cover;
    margin: 0px;
    border-radius: 0px 10px 10px 0px;
}

.about {
    padding: 10px 30px;
    width: auto;
    tex-align: justify; // border-style:solid;
    color: black;
    text-align: justify;
    line-height: 2;
    font-size: 12x;
    font-weight: 500;
}

.about-section {
    transition: color 0.3s, background-color 0.3s, transform 0.3s;
    color: #FAFAFA;
    display: grid;
    grid-gap: 0px;
    grid-template-columns: 1fr auto; // border-style:solid;
    background-color: rgba(0, 0, 0, 0.5);
    border-radius: 10px;
    border-color: red;
    margin: 30px 0px;
}

.about-section h2 {
    font-size: 20px;
}

.about-section:hover {
    background-color: rgba(0, 0, 0, 0.7);
    color: #F9BF15;
    transform: scale(1.01);
}

.about-content {
    // width:80%;
    // border-style:solid;
    padding: 30px 30px 30px 30px;
    ;
    vertical-align: middle;
}

.about-img img {
    border-radius: 0px 10px 10px 00px; // width:auto;
    // height:100%;
}

.about-img-left {
    width: auto;
    height: 300px; // border-style:solid;
    padding: 0px;
}

.about-img-left img {
    border-radius: 10px 0px 0px 10px;
    width: auto;
    height: 300px;
    margin: 0px 00px 0px 0px;
}

</style>

<template lang="html">

<div id="about" class="about">
    <div class="about-section">
        <div class="about-content">
            <h2>Welcome to Earthereum!</h2>
            <p>This is your chance to rule a country on Earth! Earthereum is a Ethereum blockchain based game where you are the main point of focus. You and many other players have the chance to rule any country you want but there’s one catch. It’ll be gone
                as quickly as you had it!</p>

            <p> Earthereum works in similar ways as other games on the Ethereum blockchain, you can take power of any country as long as you pay the right price to the treasurer. Prices will change on every purchase based on a percentage bracket. Once someone
                else pays that percentage you will have been ousted as leader BUT you will receive that cost right to your Metamask wallet. This is where the similarities stop.</p>
        </div>
        <div class="about-img" id="globe">
            <!-- <img  src="/static/globe.jpeg" alt="" > -->
        </div>
    </div>

    <div class="about-section">

        <div class="about-img-left" id="war">
            <!-- <img  src="/static/war.jpeg" alt=""> -->
        </div>
        <div class="about-content">
            <h2>  WAR!</h2>
            <p> You thought this was only about owning a country?! HA, THIS IS WAR! This is your chance to command your country and lead your alliance to victory! You will be able to join alliances, fortify your defenses and get ready for attack! This is
                where strategy is key. You will need to work together with your alliance to win the War Bounty! Beware of the War Timer!</p>
        </div>
    </div>

    <div class="about-section">
        <div class="about-content">
            <h2>Are you ready ?</h2>
            <p> Every Country in Earthereum is an ERC721 token. Once you are the leader of a country that token will be transferred to your wallet until your sneaky treasurer decides to sell you out to the next highest bidder. How long can you rule your country
                for? Can you lead your alliance to victory and win the War Bounty? All you need to jump in and start dominating Earthereum is Metamask and some Ethereum.</p>
        </div>
        <div class="about-img" id="attack">
            <!-- <img src="/static/attack.jpg" alt=""> -->
        </div>

    </div>




</div>

</template>
