<template>
  <p class="cim m-0 p-0">
    <h1>Hogyan kezdj neki</h1>
  </p>
  <div class="mb-3 row m-0 hatterszin" data-aos="fade-right" data-aos-easing="ease-in">
    <span class="col-1"></span>
    <div class="col-lg-5 col-sm-12 p-3"><img id="nagykep" src="../assets/regisztracio.png" alt=""></div>
    <p class="p-3 col m-auto">Az első lépés a regisztráció! Regisztráció során, ha megadja a szülei nevét, akkor ők már rögtön bekerülnek a családfájába.</p>
  </div>
  <div class="mb-3 row m-0 hatterszin" data-aos="fade-left" data-aos-easing="ease-in">
    <p class="p-3 col m-auto">A regisztráció után, be kell jelentkeznünk a megadott e-mail címmel és jelszóval.</p>
    <div class="p-3 col-lg-5 col-sm-12"><img src="../assets/bejelentkezes.png" alt=""></div>
  </div>
  <div class="mb-3 row m-0 hatterszin" data-aos="fade-right" data-aos-easing="ease-in">
    <span class="col-lg-1"></span>
    <div class="p-3 col-lg-5 col-sm-12"><img src="../assets/Csaladfa.png" alt=""></div>
    <p class="p-3 col m-auto">Bejelentkezés után már hozzá is férünk a saját családfánkhoz.</p>
  </div>
</template>

<script>

import AOS from 'aos';
import 'aos/dist/aos.css';

AOS.init();

</script>

<style scoped>
.cim{
    margin: 0;
    border: 1px solid black;
    color: black;
    padding: 0;
}


p{
  text-align: center;
  color: aliceblue;
  font-size: xx-large;
  font-weight: 100;
  font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif;
  font-style: normal;
  font-display: inherit;
  font-variant: inherit;
  font-feature-settings: "qwid";
  font-variant-ligatures: contextual;
  font-kerning: auto;
  letter-spacing: 0.1rem;
}
.hatterszin{
  background-color: rgba(209, 120, 3, 0.603);
  border-radius: 50px;
  margin: 2%;
  border: 1px solid black;
}
img{
  width: 100%;
  border-radius: 10px;
}
#nagykep{
  width: 70%;
}

</style>