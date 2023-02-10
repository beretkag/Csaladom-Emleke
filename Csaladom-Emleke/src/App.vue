<script>
  import { def } from '@vue/shared';
  import { RouterLink, RouterView } from 'vue-router';
  import Login from "./components/login.vue";
  import Registration from "./components/registration.vue";

  export default {
    name: "App",
    components: {
      Login,
      Registration,
      RouterLink,
      RouterView
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
  <RouterView />
</template>

<style>

</style>
