<template>

<ul class="list-group list-group-flush">
  <li class="list-group-item" v-for="csaladfa in csaladfak">
    
    {{ csaladfa.Nev }}

    <label class="switch" v-if="csaladfa.alapertelmezett = 1">
            <input type="checkbox" v-model="csekk" @change="change()" checked>
            <span class="slider round"></span>
         </label>
         <label class="switch" v-else>
            <input type="checkbox" v-model="csekk" @change="change()">
            <span class="slider round"></span>
         </label>
    
  </li>
</ul>
 
</template>

<script>
import axios from 'axios';

 export default{
    components: {
      axios
    },
    data(){
       return{
          csekk: false,
          csaladfak: [],
          elerheto:false
       }
    },
    created(){
  axios.get(this.$store.getters.baseURL + "/csaladfak", {headers: {"authorization": "JWT "+this.$store.getters.Token}}).then(res => {
    let data = res.data;
    this.csaladfak = res.data 
  })
  .catch(err => {
    console.log(err);
  });
},
methods:{
  change(){
    let rossz = {
      publikus: 0
    }
    let jo = {
      publikus: 1
    }
    if (this.csekk) {
      axios.patch(this.$store.getters.baseURL + "/csaladfak/" + 5, jo, {headers: {"authorization": "JWT "+this.$store.getters.Token}})
      alert("okay")
    }
    else{
      axios.patch(this.$store.getters.baseURL + "/csaladfak/" + 5, rossz, {headers: {"authorization": "JWT "+this.$store.getters.Token}})
    }
  }
}

 }

</script>

<style scoped>
ul li{
  background-color: rgb(226, 226, 226) !important;
}
.switch {
  position: relative;
  display: inline-block;
  width: 50px;
  height: 25px;
}

.switch input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgb(82, 82, 82);
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 17px;
  width: 17px;
  left: 2px;
  bottom: 4px;
  background-color: white;
  border: 1px solid black;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #ff7112;
}

input:focus + .slider {
  box-shadow: 0 0 1px #ff7112;
}

input:checked + .slider:before {
  -webkit-transform: translateX(30px);
  -ms-transform: translateX(30px);
  transform: translateX(30px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}
</style>