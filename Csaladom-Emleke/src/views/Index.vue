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
    <div class="row">
      <div class="col"></div>
      <div class="col-4 window m-3">
        <Login />
      </div>
    </div>
    <div class="row w-100" style="height: 200px;">
      <div class="col-8" style="background-color: purple;">
      </div>
      <div class="col-4" style="background-color: blue;">
      </div>
    </div>
    
    
  </main>
  <div class="hogyankezd" id="hogyankezdjneki">
    <HowToStart />
  </div>
  <div>
    <alertMsg variant="secondary" :text="messageText" ref='msg'/>
  </div>
</template>

<script>

  export default {
    name:'Index',
    components:{
      alertMsg,
    },
    data(){
      return{
        messageText: "Modal Szöveg",
      }
    },
    methods:{
      Registration(){
        this.$refs.msg.OpenCloseFunction();  //?????????????????????????????????????????????????????????????????????
      },
      Alert(){
        alert('csáo');
      }
    }
  }
</script>

<style>
.hogyankezd{
  margin-top: 10%;
}
.bejelentkezeslink{
  text-decoration: none;
  color: white;
}

.logo{
  width: 200px;
  height: 125px;
}

main{
  color: white;
  background-image: url('../assets/valamihatter.jpg');
  background-repeat: no-repeat;
  background-attachment: scroll;
  background-size:contain;
  background-size: cover;
  scroll-behavior: smooth;
}
.window{
  backdrop-filter: blur(3px);
  position: relative;
  color: white;
  background-color: rgba(0, 0, 0, 0.5);
  padding: 40px;
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