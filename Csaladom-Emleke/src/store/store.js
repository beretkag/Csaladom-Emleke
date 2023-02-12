import { def } from '@vue/shared';
import { createStore } from 'vuex';

    const store = createStore({
        state: {
            members: [],

        },
        getters: {
            Members (state) {
                return state.members;
            },
        }
    })

    export default store;