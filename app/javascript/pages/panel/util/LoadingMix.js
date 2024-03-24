const LoadingMix = {
  methods: {
    openOv(id) {
      this.$refs[id].$el.style.width = '100%';
    },
    closeOv(id) {
      this.$refs[id].$el.style.width = '0%';
    },
  },
};

export { LoadingMix };
