<template>
  <div class="d-flex flex-column text-center">
    <div>
        <div class="form-switch mb-3" >
            <label for="flexSwitchCheckDefault"> Sötét mód</label>
            <input class="form-check-input ml" type="checkbox" role="switch" id="flexSwitchCheckDefault">
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

<style>
.color-alpha{
    visibility: hidden !important;
}
.color-show{
    visibility: hidden !important;
}
button{
    margin: 3%;
}
label{
    margin-right: 15%;
}
</style>