<script>
  import { RouterLink, RouterView } from 'vue-router';
  import alertMsg from './components/alertMsg.vue'


  export default {
    name: "App",
    components: {
      RouterLink,
      RouterView,
      alertMsg,
    },
    data(){
      return {
        URL: "http://localhost:3000"
      }
    },
    methods:{
      baseURL(){
        return this.URL;
      }
    }
  }

</script>

<template>
  <RouterView v-slot="{Component}">
    <transition name="fade" mode="out-in">
      <component :is="Component"></component>
    </transition>
  </RouterView>
  <alertMsg/>
</template>

<style>
  /* Router Animations */

  /* Slide */
  .slide-enter-active,
  .slide-leave-active{
    transition: opacity 0.3s, transform 0.3s;
  }

  .slide-enter-from,
  .slide-leave-to{
    opacity: 0;
    transform: translateX(-30%);
  }

  /* Fade */
  .fade-enter-active,
  .fade-leave-active{
    transition: opacity 0.3s;
  }

  .fade-enter,
  .fade-leave-to{
    opacity: 0;
  }
</style>
