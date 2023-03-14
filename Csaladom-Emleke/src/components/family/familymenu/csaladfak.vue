<template>

<ul class="m-3 text-start">
  <li v-for="csaladfa in csaladfak">
    <p class="btn m-0">{{ csaladfa.Nev }}</p>
    <hr class="orange ml-3 mr-3">
  </li>
  <li>
    <p class="text-start">
      <i class="bi bi-plus-circle btn btn-sm m-0" v-if="csaladfak.length < 5" data-bs-toggle="modal" data-bs-target="#exampleModal"></i>
    </p>
  </li>
</ul>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" v-if="csaladfak.length < 5">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

 
</template>

<script>
import axios from 'axios';

 export default{
components: {
  axios
},
data(){
    return{
      csaladfak: [],
    }
},
created(){
  axios.post(this.$store.getters.baseURL+ "/user/data", {token :'JWT ' + JSON.parse(sessionStorage.getItem('csaladomemleke'))})
  .then(sajat =>{
    axios.get(this.$store.getters.baseURL + "/csaladfak/felhasznaloID/" + sajat.data.ID, {headers: {"authorization": "JWT "+this.$store.getters.Token}})
      .then(res=>{
        this.csaladfak = res.data;
      })
  })
},
methods:{

}

 }

</script>

<style scoped>

.bi-plus-circle{
  font-size: x-large;
}

.orange{
  color: #ff7112;
}

</style>