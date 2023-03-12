<template>
    <div v-if="$store.getters.alertMsg.visible" class="modal d-block alert-danger">
        <div class="modal-dialog p-0">
            <div class="modal-content">
                <div class="modal-header mb-0 alert" :class="'alert-' + $store.getters.alertMsg.style" role="alert">
                    {{ $store.getters.alertMsg.message }}
                    <button type="button" class="btn-close" @click="this.$store.commit('HideMsg')" aria-label="Close"></button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>

export default {
    name:'alertMSg',
}

</script>