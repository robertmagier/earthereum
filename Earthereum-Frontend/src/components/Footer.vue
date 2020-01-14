<style scoped>

@import '../style2.css';

</style>

<template>

<div id="Footer" class="footer">
    <div class="site-map">
        <b>Site-map:</b>

        <ul>

            <li>
                <router-link v-if="isAuthorized" @click.native="CheckAlliance()" to="admin">ADMINISTRATION</router-link>
            </li>
            <li>
                <router-link @click.native="CheckAlliance()" to="map">WORLD MAP</router-link>
            </li>
            <li>
                <router-link @click.native="CheckAlliance()" to="myoperation">MY OPERATION</router-link>
            </li>
            <li>
                <router-link @click.native="CheckAlliance()" to="statistics">STATISTICS</router-link>
            </li>
            <li>
                <router-link @click.native="CheckAlliance()" to="faq">FAQ</router-link>
            </li>
            <li>
                <router-link @click.native="CheckAlliance()" to="about">ABOUT</router-link>
            </li>
          </ul>
    </div>

    <div class="copyright">
        <p><i class="far fa-copyright "></i> Anonymous Master of International Crypto Currency War. </p>
    </div>
    <div/>

    <div class="social-links">

        <!-- <i class="fab fa-facebook fa-2x map-font"></i> -->
        <div/>
        <a href="http://discord.gg/QDHqbJZ"> <i class="fab fa-discord fa-2x map-font"></i>        </a>
        <a href="https://www.reddit.com/r/Earthereum/"> <i class="fab fa-reddit fa-2x map-font"></i>        </a>
        <a href="https://medium.com/@Earthereum"> <i class="fab fa-medium fa-2x map-font"></i>        </a>

    </div>
</div>

</template>

<script>

export default {
    name: 'Footer',

    data() {
        return {
            newUser: {},
            users: []
        }
    },
    props: {
        cname: {
            type: String,
            default: 'Foobar'
        },
        cdescription: {
            type: String,
            default: 'Foobar'
        },
        flag: {
            type: String,
            default: 'Foobar'
        },
        picture: {
            type: String,
            default: 'Foobar'
        },

    },
    methods: {
        addUser: function(e) {
            this.users.push({
                name: this.newUser.name,
                email: this.newUser.email,
                contacted: false
            });
            // console.log('add');
            e.preventDefault();

        },

        deleteUser: function(user) {
            this.users.splice(this.users.indexOf(user), 1)
        }

    },
    created: function() {
        // console.log('created ran....');
        // this.$http.get('https://jsonplaceholder.typicode.com/users')
        //     .then(function(response) {
        //         this.users = response.data;
        //     });
    },
    computed: {

    }
}

</script>
