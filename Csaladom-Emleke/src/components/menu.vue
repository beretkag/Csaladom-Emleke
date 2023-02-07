<template>
<div class="d-flex m-3">
  <div class="logodiv">
    <img src="../assets/logopng.png" class="logo" alt="Családomemléke logó">
  </div>
  <div class="container">
    <nav class="navbar navbar-expand-lg nav-fill w-100">
      <div class="container-fluid text-center">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
          <span> <i class="bi bi-list"></i> </span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
          <ul class="navbar-nav">
            <li class="nav-item">
              <RouterLink to="/"> Bejelentkezés </RouterLink>
            </li>
            <li class="nav-item">
              <a href="#hogyankezdjneki"> Hogyan kezdj neki </a>
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
button{
  border: 1px solid white !important;
}
i{
  color: white;
}
nav{
  margin-top: 2%;
}
  nav a{
    text-decoration: none !important;
    color: white;
    margin: auto;
    letter-spacing:0.05em;
  }
  li{
    text-align: center;
    display: flex;
    flex-direction: row;
    align-items: center;
    height: 3em;
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
  nav ul{
    width: 100%;
  }
  nav ul li{
  display: flex;
  justify-content: space-around;
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
