<template>
  <div class="offcanvas offcanvas-start" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvasScrolling">
    <div class="offcanvas-header">
      <h5 class="offcanvas-title">
        <img src="../../img/logopng.png" alt="Családom emléke logo" id="logo">
      </h5>
      <button type="button" class="btn btn-lg rounded-circle " data-bs-dismiss="offcanvas">
        <h2 class="m-0"><i class="bi bi-arrow-left-circle"></i></h2>
      </button>
    </div>
    <div class="offcanvas-body text-center">
      <div>
        <hr>
        <div class="m-3">
          <RouterLink :to="{name: 'Beállítások'}"><span class="link btn">Beállítások</span></RouterLink>
        </div>
        <hr>
        <div class="m-3">
          <RouterLink :to="{name: 'Felhasználó-Kezelés'}"><span class="link btn">Felhasználóezelés</span></RouterLink>
        </div>
        <hr>
        <div class="m-3">
          <RouterLink :to="{name: 'Családfák'}"><span class="link btn">Családfák</span></RouterLink>
        </div>
        <hr class="mb-3">
      </div>
      <div>
        <RouterView />
      </div>
    </div>
  </div>
</template>
    
<script>
    import { RouterLink, RouterView } from 'vue-router';

    export default {
      name: 'familymenu',
      components:{
        RouterLink,
        RouterView
      }
    }

</script>

<style scoped>
  .link{
    font-size:larger;
  }

  #logo{
    width: 120px;
  }

  #offcanvasScrolling{
    background-color: rgb(226, 226, 226);
    text-align: center;
  }
  button:hover{
    background-color: #ff7112;
    border: 1px solid black;
  }
  span:hover{
    color: #ff7112 !important;
  }


</style>
    