<script setup>
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <nav>
    <RouterLink to="/hogyankezdjneki"> Hogyan kezdj neki </RouterLink>
    <RouterLink to="/beallitasok"> Beállítások </RouterLink>
    <RouterLink to="/felhasznalokezeles"> Felhasználókezelés</RouterLink>
    <RouterLink to="/elerhetosegek"> Elérhetőségek </RouterLink>
  </nav>
</template>

<style>
  nav{
    display: flex;
    flex-direction: row;
    justify-content: space-around;
    text-decoration: none;
    color: black;
  }
  a{
    text-decoration: none;
    color: black;
  }
  a:hover{
  background-image: url('https://scottyzen.sirv.com/Images/v/button.png');
  background-size: 100% 100%;
  color: #27262c;
  animation: spring 300ms ease-out;
  text-shadow: 0 -1px 0 #ef816c;
	font-weight: bold;
  }
  a:active{
    transform: translateY(4px);
  }

</style>
