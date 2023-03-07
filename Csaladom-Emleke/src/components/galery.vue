<template>
  <button class="btn btn-primary" @click="Upload()">Kép feltöltése</button>
  <input type="file" multiple class="form-control m-3" @change="SelectImage" accept="image/*">

  <img :src="preview" alt="thumbnail" v-for="preview in previews">
  <!-- Gallery -->
  <div class="container">
         <div class="row">
            <div class="col-lg-12 text-center my-2">
                <h4>Isotope filter magical layouts with Bootstrap 4</h4>
            </div>
         </div>
         <div class="portfolio-menu mt-2 mb-4">
            <ul>
               <li class="btn btn-outline-dark active" data-filter="*">All</li>
               <li class="btn btn-outline-dark" data-filter=".gts">Girls T-shirt</li>
               <li class="btn btn-outline-dark" data-filter=".lap">Laptops</li>
               <li class="btn btn-outline-dark text" data-filter=".selfie">selfie</li>
            </ul>
         </div>
         <div class="portfolio-item row">
            <div v-for="picture in pictures" class="item selfie col-lg-3 col-md-4 col-6 col-sm">
               <a :src="'../../public/uploads/' +picture.Nev " class="fancylight popup-btn" data-fancybox-group="light"> 
               <img class="img-fluid" :src="'../../public/uploads/' +picture.Nev " alt="">
               </a>
            </div>
         </div>
      </div>
<!-- Gallery -->
</template>
<style>

/*https://bootsnipp.com/snippets/1dPDV */


</style>
<script>
import axios from 'axios';


export default{
  props:{
        nodeId:String

    },
  data(){
    return{
      images: [],
      previews: [], 
      pictures:[]
    }
  },
  created(){
    axios.get(this.$store.getters.baseURL+"/kepek/csaladtagID/"+this.nodeId, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
        .then(res=>{
            this.pictures=res.data
        })
  },
  methods:{
    SelectImage(e){
      this.images = e.target.files;


      this.previews = [];
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
      data.append('files', this.images);
      console.log(this.images);
      axios.post(this.$store.getters.baseURL + "/fileUpload", data, {
        headers: {
          "authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke')),
          'Content-Type': 'multipart/form-data'
        }
      })
      .then(res=>{
        this.images = [],
        this.previews = []
      })
    }
  }
}
</script>
