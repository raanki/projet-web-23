<template>
  <VCard>
    <v-card-title class="title">BARCODE EQUIPMENT #{{ itemId }}  𝄃𝄃𝄂𝄂𝄀𝄁𝄃𝄂𝄂𝄃</v-card-title>
    <VTable>
      <div class="qrcode-container">
        <div class="qrcode">
          <svg id="qrcode"></svg>
        </div>
      </div>
    </VTable>
  </VCard>
</template>

<script setup>
import { useRoute } from 'vue-router';
import { onMounted, onBeforeUnmount } from 'vue'
import JsBarcode from 'jsbarcode'

const route = useRoute();
const itemId = route.params.id;

function generateBarcode() {
  const formattedItemId = itemId.toString().padStart(8, '0');

  const screenWidth = window.innerWidth;

  // Ajuster la taille du QR code en fonction de la taille de l'écran
  let width, height, fontSize;
  if (screenWidth < 600) {
    width = 2;
    height = 80;
    fontSize = 10;
  } else if (screenWidth < 1200) {
    width = 3;
    height = 100;
    fontSize = 14;
  } else {
    width = 5;
    height = 150;
    fontSize = 20;
  }

  JsBarcode("#qrcode", formattedItemId, {
    format: "CODE128",
    displayValue: true,
    width: width,
    height: height,
    fontSize: fontSize,
  });
}

onMounted(() => {
  generateBarcode();
  window.addEventListener('resize', generateBarcode);
});

onBeforeUnmount(() => {
  window.removeEventListener('resize', generateBarcode);
});
</script>

<style scoped>
.qrcode-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 70vh;
}

.qrcode {
  text-align: center;
}

.title {
  text-align: center;
  font-size: 24px;
  margin-bottom: 20px;
  font-weight: bold;
}
</style>


