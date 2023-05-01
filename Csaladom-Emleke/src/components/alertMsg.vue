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

<style scoped>
.modal-content{
    animation: splash 1s normal forwards ease-in-out;
}

@keyframes splash {
    from {
        opacity: 0;
        transform: scale(0, 0);
    }
    50% {
        opacity: 1;
        transform: scale(1.1, 1.1);
    }
    to {
        transform: scale(1, 1);
    }
}
</style>