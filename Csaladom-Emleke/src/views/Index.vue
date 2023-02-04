<script setup>
  import Registration from '../components/registration.vue';
  import Login from '../components/login.vue';

</script>

<template>
  <main>
    <div class="d-flex pe-2 flex-row-reverse m-3">
      <div class="d-flex flex-column justify-content-between bejelentkezes col-md-4">
        <Registration />
        
      </div>
    </div>
  </main>
</template>

<style>
.nevekdiv{

}
.fejlecdiv{

}
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