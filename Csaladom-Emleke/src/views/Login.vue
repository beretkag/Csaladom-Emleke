<script>
import Registration from '../components/registration.vue';


</script>
<template>
  <div class="fejlecdiv d-flex justify-content-around">
    <div class="logodiv">
      <img src="../assets/logopng.png" class="logo" alt="Családomemléke logó">
    </div>
    <div></div>
    <div class="bejelentkezesdiv">
      <a href="#bejelentkezes" class="bejelentkezeslink">Bejelentkezés</a>
    </div>
  </div>
   <div class="d-flex pe-2 flex-row-reverse">
    <div class="d-flex flex-column justify-content-between bejelentkezes col-md-4">
      <Registration/>
   </div>
   </div>
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