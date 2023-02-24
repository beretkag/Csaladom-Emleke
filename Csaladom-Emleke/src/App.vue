<script>
  import { def } from '@vue/shared';
  import { RouterLink, RouterView } from 'vue-router';

  export default {
    name: "App",
    components: {
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
