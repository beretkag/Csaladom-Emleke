<template>
  <button class="btn btn-primary" @click="Upload()">Kép feltöltése</button>
  <input type="file" multiple class="form-control m-3" @change="SelectImage" accept="image/*">

  <img :src="preview" alt="thumbnail" v-for="preview in previews">
  <!--Carousel-->
  <div class="row">
      <span class="col-3"></span>
      <div id="carouselExampleIndicators" class="carousel slide col-6">
      <div class="carousel-indicators">
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
      </div>
      <div class="carousel-inner">
        <div class="carousel-item" :class="{'active':index==0 }">
          <img src="../assets/picafish.jpg" class="d-block w-100" alt="...">
        </div>
        <div class="carousel-item">
          <img src="../assets/crazyfish.jpg" class="d-block w-100" alt="...">
        </div>
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>
  </div>
</template>
<style>

</style>
<script>
import axios from 'axios';


export default{
  data(){
    return{
      images: [],
      previews: [], 
    }
  },
  methods:{
    SelectImage(e){
      this.images = e.target.files;


      this.previews = [];
      console.log(this.images);
      for (let i = 0; i < this.images.length; i++) {
        this.AddPreview(this.images[i])        
      }
    },
    AddPreview(file){
      const reader = new FileReader();
      reader.addEventListener(
        "load",
        () => {
          this.previews.push(reader.result);
        },
        false
      );
  
      if (file) {
        reader.readAsDataURL(file);
      }
    },
    Upload(){
      let data = new FormData();
      data.append('file', this.images);
      axios.post(this.$store.getters.baseURL + "/fileUpload", data)
      .then(res=>{
        console.log(res);
        this.images = [],
        this.previews = []
      })
    }
  }
}
</script>
