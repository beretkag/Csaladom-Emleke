<template>
  <div class="d-flex flex-column text-center">
    <div>
        <div class="form-switch mb-3" >
          Sötét mód
          <label class="switch">
            <input type="checkbox">
            <span class="slider round"></span>
        </label>
        </div>
    </div>

      <div class="mb-3">
          <button class="btn btn-dark mb-3" @click="Ferfi()">
              Férfi szín
          </button>
          <button class="btn btn-dark mb-3" @click="Noi()">
              Női szín 
          </button>
          <div v-if="ferfi">
              Férfi szín módosítása
          </div>
          <div v-if="noi">
            Női szín módosítása
          </div>
        <div v-if="szin" :style="{background: color}">
            <ColorPicker
                theme="dark"
                :color="color"
                :sucker-area="suckerArea"
                @changeColor="changeColor">
            </ColorPicker>
  </div>
      </div>
 
  </div>

</template>

<script>
import { ColorPicker } from 'vue-color-kit'
  import 'vue-color-kit/dist/vue-color-kit.css'

  export default {
    components: {
      ColorPicker,
    },
    data() {
      return {
        color: '#59c7f9',
        suckerCanvas: null,
        suckerArea: [],
        ferfi: false,
        noi:false,
        szin:false
      }
    },
    methods: {
      changeColor(color) {
        const { r, g, b, a } = color.rgba
        this.color = `rgba(${r}, ${g}, ${b}, ${a})`
      },
      Ferfi(){
        this.ferfi = true;
        this.noi = false;
        this.szin = true;
      },
      Noi(){
        this.ferfi = false;
        this.noi = true;
        this.szin = true;
      }
    },
  }

</script>

<style scoped>
button{
    margin: 3%;
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
.color-alpha{
    visibility: hidden !important;
}
.color-show{
    visibility: hidden !important;
}
.color-type{
  visibility: hidden !important;
}
</style>