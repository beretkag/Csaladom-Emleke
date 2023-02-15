<template>
    <h1>
        Családfa
    </h1>
    <div id="tree" ref="tree"></div>
</template>

<script>

    import FamilyTree from '@balkangraph/familytree.js'

    export default {
        name: 'tree',
        data(){
            return {
                family: {}
            }
        },
        methods: {
            mytree: function(domEl, x) {
                this.family = new FamilyTree (domEl, {
                    nodes: x,
                    nodeBinding: {
                        field_0: "teljesnev",
                        field_1: "szulido",
                        img_0: "img"
                    },
                    nodeTreeMenu: true,
                    editForm: {
                        titleBinding: "name",
                        photoBinding: "photo",
                        generateElementsFromFields: false,
                        addMore: false,
                        elements: [
                            [
                                {type: 'textbox', label: "Vezetéknév", binding: 'vezeteknev'},
                                {type: 'textbox', label: "Keresztnév", binding: 'keresztnev'}
                            ],
                            { type: 'textbox', label: "Telefonszám", binding: 'telefonszam'},
                            { type: 'textbox', label: "Neme", binding: 'nem'},
                            [
                                { type: 'date', label: "Születési dátum", binding: 'szulido'},
                                { type:'date', label: "Halálozási dátum", binding: 'halido'},
                            ],
                            { type: 'textbox', label: "Születési helye", binding: 'szulhely'},
                        ],
                        buttons: {
                            edit: {
                                icon: FamilyTree.icon.edit(24, 24, '#fff'),
                                text: 'Edit',
                                hideIfEditMode: true,
                                hideIfDetailsMode: false
                            },
                            share: null,
                            pdf: null,
                            remove: {
                                icon: FamilyTree.icon.remove(24, 24, '#fff'),
                                text: 'Törlés'
                            }
                        }
                    }
                });
            },
            Rajzol(){
                this.mytree(this.$refs.tree, this.$store.getters.Members);

                this.family.onUpdateNode((args) => {
                console.log(args.addNodesData);
                console.log(args.updateNodesData);
                console.log(args.removeNodeId);
                });

                this.family.editUI.on('button-click', function (sender, args) {
                if (args.name == 'remove') {
                    //alert('Törlés')
                }
            });
            },
        },
    }
</script>