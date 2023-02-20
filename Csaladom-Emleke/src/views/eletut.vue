<template>

</template>
<script>
import axios from 'axios';

export default{
    props:{
        nodeid:String

    },
    data(){
        return{
            node:{},
            paragraphs:[],
        }
    },
    created(){
        this.node=this.$store.getters.members.find(x=> x.id ==this.nodeid)
        axios.get('')
    }

}
</script>