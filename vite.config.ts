import { defineConfig } from 'vite';
import RubyPlugin from 'vite-plugin-ruby';
import vue from '@vitejs/plugin-vue';
const path = require('path')

export default defineConfig({
  resolve: {
    extensions: ['.mjs', '.js', '.ts', '.jsx', '.tsx', '.json', '.vue'],
    alias: {
      '~bootstrap': path.resolve(__dirname, 'node_modules/bootstrap'),
    }
  },
  plugins: [vue(), RubyPlugin()],
  css: {
    preprocessorOptions: {
      scss: {
        sourceMap: false,
        additionalData(source: any, fp: any) {
          if (fp.endsWith('variables.scss')) return source;

          return `@import "@/assets/css/_variables.scss"; ${source}`;
        },
      },
    },
  },
});
