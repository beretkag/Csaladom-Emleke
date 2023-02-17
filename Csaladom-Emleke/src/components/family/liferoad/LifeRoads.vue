<template>

    <div class="tipp">
    <button class="btn btn-dark"> <i class="bi bi-info-circle"></i> </button>
  <span class="tipptxt"> A megfelelő rokon sorára rákkattintva meg tudja tekinteni a felvitt életútját.</span>
</div>

    <table class="table table-hover table-dark">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Név</th>
      <th scope="col">Életút</th>
    </tr>
  </thead>
  <tbody>
    <tr v-for="eletut, index in eletutak">
      <th scope="row" class="align-middle"> {{ index + 1}}</th>
      <td class="align-middle">{{ /*  felhasználó rokonainak neve */ }}</td>
      <td class="align-middle">{{ eletut.szoveg}}</td>
    </tr>
  </tbody>
</table>

</template>
   
<script>
   export default{
    data(){
    return {
        eletutak: []
           }
      },
    created(){

axios.get(this.$store.getters.baseURL + "/eletut").then(res => {
    let data = res.data;
        this.eletutak = res.data
})
.catch(err => {
    console.log(err);
})
    }
}
</script>
   
<style>
   .tipp {
    float: right;
  position: relative;
}

.tipp .tipptxt {
  visibility: hidden;
  width: 400px;
  background-color: #555;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 1px;
  position: absolute;
  z-index: 1;
  margin-left: -450px;
  opacity: 0;
  transition: opacity 0.3s;
}

.tipp .tipptxt::after {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: #555 transparent transparent transparent;
}

.tipp:hover .tipptxt {
  visibility: visible;
  opacity: 1;
}
</style>