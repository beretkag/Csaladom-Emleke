<script>
  import { def } from '@vue/shared';
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
  <RouterView/>
  <alertMsg/>
</template>

<style>

</style>
