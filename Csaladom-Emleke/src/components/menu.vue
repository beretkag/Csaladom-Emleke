<template>
<div class="d-flex m-3">
  <div class="logodiv">
    <img src="../assets/logopng.png" class="logo" alt="Családomemléke logó">
  </div>
  <div>
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
      <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
          <ul class="navbar-nav">
            <li class="nav-item">
              <RouterLink to="/"> Bejelentkezés </RouterLink>
            </li>
            <li class="nav-item">
              <RouterLink to="/hogyankezdjneki"> Hogyan kezdj neki </RouterLink>
            </li>
            <li class="nav-item">
              <RouterLink to="/beallitasok"> Beállítások </RouterLink>
            </li>
            <li class="nav-item">
              <RouterLink to="/felhasznalokezeles"> Felhasználókezelés</RouterLink>
            </li>
            <li class="nav-item">
              <RouterLink to="/elerhetosegek"> Elérhetőségek </RouterLink>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  </div>
</div>
</template>

<script setup>
import { RouterLink, RouterView } from 'vue-router'
</script>

<style>

  nav{
    margin-top: 1%;
    text-decoration: none !important;
  }

  nav a{
    text-decoration: none !important;
    color: white;
  }
  li{
    text-decoration: none;
    color: white;
  }
  li:hover a{
    color: black !important; 
  }
  li:hover{
  background-color: #ff7112;
  animation: spring 500ms ease-out;
	font-weight: bold;
  height: 3em;
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
