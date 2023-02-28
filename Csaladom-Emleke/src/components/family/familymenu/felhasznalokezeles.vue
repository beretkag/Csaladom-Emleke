<template>
    <div class="d-flex flex-row justify-content-around text-center">
        <div>
            <RouterLink :to="{name: 'namemod'}"><button class="btn btn-dark"> Név </button></RouterLink>
        </div>
        <div>
            <RouterLink :to="{name: 'emailmod'}"><button class="btn btn-dark"> E-mail </button></RouterLink>
        </div>
        <div>
            <RouterLink :to="{name: 'passmod'}"><button class="btn btn-dark"> Jelszó </button></RouterLink>
        </div>
    </div>

    <div>
        <RouterView/>
    </div>
</template>

<script>
import { RouterLink, RouterView } from 'vue-router';

export default {
  name: 'felhasznalokezeles',
  components:{
    RouterLink,
    RouterView
  }
}
</script>

<style>

</style>