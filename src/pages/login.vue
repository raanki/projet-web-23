<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useStore } from 'vuex'
import { API_URL } from '/src/env'

const router = useRouter()
const store = useStore()

const form = ref({
  mail: '',
  password: '',
  remember: false,
})

const isPasswordVisible = ref(false)
const errorMessage = ref('')
const fieldErrors = ref({
  mail: '',
  password: '',
})

async function submitForm() {
  errorMessage.value = ''
  fieldErrors.value = {
    mail: '',
    password: '',
  }

  if (!form.value.mail) {
    fieldErrors.value.mail = 'Please complete the email field.'
  }
  if (!form.value.password) {
    fieldErrors.value.password = 'Please complete the password field.'
  }

  if (fieldErrors.value.mail || fieldErrors.value.password) {
    return
  }

  try {
    const response = await fetch(`${API_URL}api/login`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(form.value),
    })
    const result = await response.json()
    if (result.status === 'success') {
      store.dispatch('login', result.user)
      router.push('/')
    } else {
      errorMessage.value = result.message
      console.error('Login failed:', result.message)
    }
  } catch (error) {
    errorMessage.value = 'An error occurred during login.'
    console.error('Error during login:', error)
  }
}
</script>

<template>
  <div class="auth-wrapper d-flex align-center justify-center pa-4">
    <VCard class="auth-card pa-4 pt-7" max-width="448">
      <VCardItem class="justify-center">
        <template #prepend>
          <div class="d-flex">
            <div class="d-flex text-primary" v-html="logo"/>
          </div>
        </template>
        <VCardTitle class="text-2xl font-weight-bold">sneat</VCardTitle>
      </VCardItem>

      <VCardText class="pt-2">
        <h5 class="text-h5 mb-1">Welcome to sneat! 👋🏻</h5>
        <p class="mb-0">Please sign-in to your account and start the adventure</p>
      </VCardText>

      <!-- Section pour afficher le message d'erreur général -->
      <VCardText v-if="errorMessage" class="text-red-500 mb-2">
        {{ errorMessage }}
      </VCardText>

      <VCardText>
        <VForm @submit.prevent="submitForm" style="margin-top: 30px !important;">
          <VRow>
            <!-- email -->
            <VCol cols="12">
              <VTextField
                v-model="form.mail"
                autofocus
                placeholder="johndoe@email.com"
                label="Email"
                type="email"
                :error-messages="fieldErrors.mail"
                :outlined="fieldErrors.mail ? 'true' : 'false'"
                :rules="[() => !fieldErrors.mail || fieldErrors.mail]"
              />
            </VCol>

            <!-- password -->
            <VCol cols="12">
              <VTextField
                v-model="form.password"
                label="Password"
                placeholder="············"
                :type="isPasswordVisible ? 'text' : 'password'"
                :append-inner-icon="isPasswordVisible ? 'bx-hide' : 'bx-show'"
                @click:append-inner="isPasswordVisible = !isPasswordVisible"
                :error-messages="fieldErrors.password"
                :outlined="fieldErrors.password ? 'true' : 'false'"
                :rules="[() => !fieldErrors.password || fieldErrors.password]"
              />

              <!-- remember me checkbox -->
              <div class="d-flex align-center justify-space-between flex-wrap mt-1 mb-4">
                <VCheckbox v-model="form.remember" label="Remember me"/>
                <RouterLink class="text-primary ms-2 mb-1" to="javascript:void(0)">Forgot Password?</RouterLink>
              </div>

              <!-- login button -->
              <VBtn block type="submit">Login</VBtn>
            </VCol>

            <!-- create account -->
            <VCol cols="12" class="text-center text-base">
              <span>New on our platform?</span>
              <RouterLink class="text-primary ms-2" to="/register">Create an account</RouterLink>
            </VCol>
          </VRow>
        </VForm>
      </VCardText>
    </VCard>
  </div>
</template>

<style lang="scss">
@use "@core/scss/template/pages/page-auth.scss";
</style>
