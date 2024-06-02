<script setup>
import {ref, onMounted} from 'vue';
import axios from 'axios';
import {useTheme} from 'vuetify';
import illustrationJohnDark from '@images/cards/illustration-john-dark.png';
import illustrationJohnLight from '@images/cards/illustration-john-light.png';
import {API_URL} from '/src/env';

const {global} = useTheme();
const illustrationJohn = computed(() => global.name.value === 'dark' ? illustrationJohnDark : illustrationJohnLight);

const user = ref({});

onMounted(async () => {
  try {
    const response = await axios.get(`${API_URL}api/check-auth`);
    if (response.data.status === 'success') {
      user.value = response.data.user;
    } else {
      // Rediriger vers la page de login si non authentifié
      router.push('/login');
    }
  } catch (error) {
    console.error('Failed to fetch user:', error);
    router.push('/login');
  }
});
</script>

<template>
  <VCard class="text-center text-sm-start">
    <VRow no-gutters>
      <VCol cols="12" sm="8" order="2" order-sm="1">
        <VCardItem style="min-height: 130px !important;">
          <VCardTitle class="text-md-h5 text-primary">
            Hello {{ user.firstname }}! 🎉
          </VCardTitle>
        </VCardItem>
        <VCardText>
          <span>
            Here are the daily statistics 🤩.
            <br>
          </span>
          <br>
        </VCardText>
      </VCol>
      <VCol cols="12" sm="4" order="1" order-sm="2" class="text-center">
        <img
          :src="illustrationJohn"
          :height="$vuetify.display.xs ? '150' : '175'"
          :class="$vuetify.display.xs ? 'mt-6 mb-n2' : 'position-absolute'"
          class="john-illustration flip-in-rtl"
        >
      </VCol>
    </VRow>
  </VCard>
</template>

<style lang="scss" scoped>
.john-illustration {
  inset-block-end: -0.0625rem;
  inset-inline-end: 3rem;
}
</style>
