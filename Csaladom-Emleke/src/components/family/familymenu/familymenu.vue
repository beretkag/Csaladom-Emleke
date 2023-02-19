<template>
  <div class="offcanvas offcanvas-start" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvasScrolling">
    <div class="offcanvas-header">
      <h5 class="offcanvas-title">
        <img src="../../img/logopng.png" alt="Családom emléke logo" id="logo">
      </h5>
      <button type="button" class="btn btn-lg btn-primary rounded-circle" data-bs-dismiss="offcanvas">
        <h2 class="m-0"><i class="bi bi-arrow-left-circle"></i></h2>
      </button>
    </div>
    <div class="offcanvas-body">
      <div>
        <hr>
        <div class="m-3">
          <RouterLink :to="{name: 'Beállítások'}"><span class="link btn">Beállítások</span></RouterLink>
        </div>
        <hr>
        <div class="m-3">
          <RouterLink :to="{name: 'Felhasználó-Kezelés'}"><span class="link btn">Felhasználó Kezelés</span></RouterLink>
        </div>
        <hr>
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
  }


</style>
    