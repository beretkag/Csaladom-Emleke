<template>
    <navmenu />
    <main>
        <h1>
            család
        </h1>
        <contacts v-if = "page='contacts'"  />
        <familytree v-else-if= "page='familytree'" />
        <settings v-else-if= "page='settings'"/>
    </main>
</template>

<script>
    import navmenu from '../components/family/familymenu.vue'
    import contacts from '../components/family/contacts.vue'
    import familytree from '../components/family/familytree.vue'
    import settings from '../components/family/settings.vue'

    export default{
        components:
        {
            navmenu,
            contacts,
            familytree,
            settings
        },
        data(){
      return {
        page: ""
      }
    },
    methods:{
      settings(bool){
        this.page = settings;
      }
    }
    }
</script>

<style scoped>
    body{
        background-color: grey !important;
    }
    main{
        background-color: grey;
    }
</style>