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
      <div id="maindiv">
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
        <hr>
        <div class="m-3">
            <a data-bs-toggle="modal" data-bs-target="#exampleModal" class="mb-3"> <span class="link btn"> Felhasználók</span> </a>
        </div>
        <hr>
      </div>
      <div>
        <RouterView />
      </div>

    </div>
  </div>
  <div>
    <manage />
  </div>

  <!-- Modal -->

</template>
    
<script>
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
          sidebarStyle:{},

        }
      },
      created(){
        
        

    },
    watch:{
      '$store.getters.Settings' :{
        handler: function(Settings) {
          if (this.$store.getters.Settings.darkmode) {
          this.sidebarStyle={
            bgcolor:"rgb(43, 43, 43)",
            color:"white",
            inputbgcolor:"rgb(51,51,51)",
            inputlabelcolor:"white",
            
          }
        }else{
          this.sidebarStyle={
            bgcolor:"rgb(226, 226, 226)",
            color:"black",
            inputbgcolor:"white",
            inputlabelcolor:"black",
            
          }
        }
        },
        deep: true,
      }
    }

      
    }

</script>

<style >

  .familytreelabel{
    color: v-bind('sidebarStyle.inputlabelcolor');
  }
  .familytreeinput{
    background-color: v-bind('sidebarStyle.inputbgcolor');
  }
  .familytreeinput:focus{
    background-color: v-bind('sidebarStyle.inputbgcolor');
    background-color: v-bind('sidebarStyle.inputbgcolor');
  }
  .offcanvas{
    z-index: 200 !important;
    color: v-bind('sidebarStyle.color') !important;
  }
  #maindiv *{
    color: v-bind('sidebarStyle.color');
  }

  .link{
    font-size:larger;
  }

  #logo{
    width: 120px;
  }

  #offcanvasScrolling{
    background-color: v-bind('sidebarStyle.bgcolor');
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
    