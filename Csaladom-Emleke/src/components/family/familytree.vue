<template>
    <div id="tree" ref="tree"></div>
</template>

<script>

    import FamilyTree from '@balkangraph/familytree.js'

    export default {
        name: 'tree',
        methods: {
            mytree: function(domEl) {
                this.family = new FamilyTree (domEl, {
                    nodes: this.$store.getters.Members,
                    nodeBinding: {
                        field_0: "name",
                        img_0: "img"
                    },
                    nodeMenu: {
                        details: { text: "Details" },
                        edit: { text: "Edit" }
                    },
                    nodeTreeMenu: true,
                    editForm: {
                        titleBinding: "name",
                        photoBinding: "photo",
                        generateElementsFromFields: false,
                        addMore: 'Add more elements',
                        addMoreBtn: 'Add element',
                        addMoreFieldName: 'Element name',
                        elements: [
                            { type: 'textbox', label: 'Teljes név', binding: 'name' },

                            [
                                { type: 'date', label: 'Birth Date', binding: 'birthDate' },
                                { type: 'date', label: 'Death Date', binding: 'deathDate' }
                            ],
                            [
                                { type: 'select', options: [{ value: 'bg', text: 'Bulgaria' }, { value: 'ru', text: 'Russia' }, { value: 'gr', text: 'Greece' }], label: 'Country', binding: 'country' },
                                { type: 'textbox', label: 'City', binding: 'city' },
                            ],
                            { type: 'textbox', label: 'Photo Url', binding: 'ImgUrl', btn: 'Upload' },
                            { type: 'textbox', label: 'Phone', binding: 'Mobile' },
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
            }
        },
        mounted(){
            this.mytree(this.$refs.tree);

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
        }
    }
</script>