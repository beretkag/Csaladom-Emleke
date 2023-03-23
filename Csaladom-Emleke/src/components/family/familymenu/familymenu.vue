<template>
  <div class="offcanvas offcanvas-start" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvasScrolling">
    <div class="offcanvas-header">
      <h5 class="offcanvas-title">
        <img src="../../img/logopng.png" alt="Családom emléke logo" id="logo">
      </h5>
      <div class="text-wrap text-break">
        {{ $store.getters.Nev }}
      </div>
      <button class="btn btn-lg rounded-circle " data-bs-dismiss="offcanvas">
        <h2 class="m-0"><i class="bi bi-arrow-left-circle familytreetext"></i></h2>
      </button>
    </div>
    <div class="offcanvas-body text-center">
      <div id="maindiv">
        <hr>

        <div class="m-3">
          <RouterLink :to="{name: 'index'}"><span class="link btn" @click="LogOut()">Kijelentkezés</span></RouterLink>
        </div>
        <hr>
        <div class="m-3">
          <RouterLink :to="{name: 'Beállítások'}"><span class="link btn">Beállítások</span></RouterLink>
        </div>
        <hr>
        <div class="m-3">
          <RouterLink :to="{name: 'Felhasználó-Kezelés'}"><span class="link btn">Felhasználókezelés</span></RouterLink>
        </div>
        <hr>
        <div class="m-3">
          <RouterLink :to="{name: 'Családfák'}"><span class="link btn">Családfák</span></RouterLink>
        </div>
        <span v-if="isAdmin">
          <hr>
          <div class="m-3">
              <a data-bs-toggle="modal" data-bs-target="#exampleModal" class="mb-3"> <span class="link btn">Felhasználók</span> </a>
          </div>
        </span>
        <hr>
      </div>
      <div>
        <RouterView v-slot="{Component}">
          <transition name="slide" mode="out-in">
            <component :is="Component"></component>
          </transition>
        </RouterView>
      </div>

    </div>
  </div>
  <div>
    <manage />
  </div>

  <!-- Modal -->

</template>
    
<script>
  import axios from 'axios';
  import { RouterLink, RouterView } from 'vue-router';
  import manage from '../familymenu/admin/felhasznalok.vue'

  export default {
    props:{
      csaladfaID: String,
    },
    name: 'familymenu',
    components:{
      RouterLink,
      RouterView,
      manage
    },
    data(){
      return{
        isAdmin:undefined
      }
    },
    created(){
      axios.post(this.$store.getters.baseURL+ "/user/data", {token :'JWT ' + JSON.parse(sessionStorage.getItem('csaladomemleke'))})
        .then(res => {
          this.ready=true;
          if (res.data.jogosultsag == 2) {
            this.isAdmin = true
          }
        })
    },
    methods:{
      LogOut(){
        sessionStorage.removeItem('csaladomemleke')
      },  
    }
  }

</script>


<style scoped>
  .link{
    font-size:larger;
  }

  .btn:active{
    border-color: transparent;
  }

  #logo{
    width: 120px;
  }

  button:hover{
    background-color: #ff7112;
    border: 1px solid black;
  }
  span:hover{
    color: #ff7112 !important;
  }


</style>
    