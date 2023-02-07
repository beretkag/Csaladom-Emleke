<script setup>
  import Registration from '../components/registration.vue';
  import HowToStart from '../components/howtostart.vue'
  import Login from '../components/login.vue';
  import alertMsg from '../components/alertMsg.vue';

</script>

<template>
  <main>
    <div class="d-flex pe-2 flex-row-reverse m-3">
      <div class="d-flex flex-column justify-content-between bejelentkezes col-md-4">
        <Registration />
      </div>
    </div>
    <HowToStart />
    
  </main>
  <div>
    <button class="btn btn-primary" @click="Registration()">Kintről</button>
    <alertMsg :visible="false" variant="secondary" :text="messageText" ref="msg"/>
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
      }
    }
  }
</script>

<style>
.bejelentkezeslink{
  text-decoration: none;
  color: white;
}
.bejelentkezeslink:hover{
  color: #ff7112;
}
.bejelentkezesdiv{
  margin-top: 50px;
}
.logo{
  width: 200px;
  height: 125px;

}
h1{
 color:white;
}
body{
  background-image: url('../assets/valamihatter.jpg');
  background-repeat: no-repeat;
  background-attachment: scroll;
  background-size:contain;
  background-size: cover;
}
.bejelentkezes{
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