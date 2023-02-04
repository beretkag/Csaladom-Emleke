<template>
<div class="d-flex m-3">
  <div class="logodiv">
    <img src="../assets/logopng.png" class="logo" alt="Családomemléke logó">
  </div>
  <nav class="d-flex justify-content-around w-100">
    <RouterLink to="/"> Bejelentkezés </RouterLink>
    <RouterLink to="/hogyankezdjneki"> Hogyan kezdj neki </RouterLink>
    <RouterLink to="/beallitasok"> Beállítások </RouterLink>
    <RouterLink to="/felhasznalokezeles"> Felhasználókezelés</RouterLink>
    <RouterLink to="/elerhetosegek"> Elérhetőségek </RouterLink>
  </nav>
</div>
</template>

<script setup>
import { RouterLink, RouterView } from 'vue-router'
</script>

<style>
  nav{
    margin-top: 1%;
    display: flex;
    flex-direction: row;
    justify-content: space-around;
    text-decoration: none;
  }
  nav a{
    text-decoration: none;
    color: white;
    padding: 1%;
    height: 3em !important;
    
  }
  nav a:hover{
  background-color: #ff7112;
  color: #27262c;
  animation: spring 500ms ease-out;
  text-shadow: 0 -1px 0 #ef816c;
	font-weight: bold;
  }
  nav a:active{
    transform: translateY(4px);
  }

  
@keyframes spring {
  15% {
    -webkit-transform-origin: center center;
    -webkit-transform: scale(1.2, 1.1);
  }
  40% {
    -webkit-transform-origin: center center;
    -webkit-transform: scale(0.95, 0.95);
  }
  75% {
    -webkit-transform-origin: center center;
    -webkit-transform: scale(1.05, 1);
  }
  100% {
    -webkit-transform-origin: center center;
    -webkit-transform: scale(1, 1);
  }
}
</style>
