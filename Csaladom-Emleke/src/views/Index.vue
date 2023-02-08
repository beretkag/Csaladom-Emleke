<script setup>
  import Registration from '../components/registration.vue';
  import HowToStart from '../components/howtostart.vue'
  import Login from '../components/login.vue';
  import alertMsg from '../components/alertMsg.vue';
  import navmenu from '../../src/components/menu.vue';

</script>

<template>
  <main>
    <navmenu />
    <div class="row m-0">
      <div class="col-lg-7 col-md col-sm-12"></div>
      <div class="col-lg-4 col-md-6 window p-3">
        <Login v-if="isLogin" />
        <Registration v-else />
      </div>
      <div class="col-lg col-md col-sm"></div>
    </div>
    
  </main>
  <div class="hogyankezd" id="hogyankezdjneki">
    <HowToStart />
  </div>
  <div>
    <alertMsg variant="secondary" ref='msg'/>
  </div>
</template>

<script>

  export default {
    name:'Index',
    components:{
      alertMsg,
      navmenu
    },
    data(){
      return {
        isLogin: false
      }
    },
    methods:{
      isLoginSet(bool){
        alert('másik oldalon')
        this.isLogin = bool;
      }
    }
  }
</script>

<style scoped>
.hogyankezd{
  margin-top: 10%;
}
.bejelentkezeslink{
  text-decoration: none;
  color: white;
}

main{
  padding: 0;
  color: white;
  background-image: url('../assets/valamihatter.jpg');
  background-repeat: no-repeat;
  background-attachment: scroll;
  background-size: cover;
  scroll-behavior: smooth;
  padding-bottom: 8vh;
  min-height: 100vh;
}
.window{
  backdrop-filter: blur(3px);
  color: white;
  background-color: rgba(0, 0, 0, 0.5);
  border-radius: 10px;
}
  #forgotpass{
    text-decoration: none ;
    color: grey;
  }
  #loginbutton{
      background-color: #ff7112;
  }

</style>