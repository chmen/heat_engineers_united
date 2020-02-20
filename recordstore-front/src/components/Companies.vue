<template>
  <div class="max-w-md m-auto py-10">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4">Add a new company</h3>
    <form action="" @submit.prevent="addCompany">
      <div class="mb-6">
        <input class="input"
          autofocus autocomplete="off"
          placeholder="Company name"
          v-model="newCompany.name" />
      </div>
      <input type="submit" value="Add Company" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green-500 hover:bg-green-700 block w-full py-4 text-white items-center justify-center" />
<!--       <input type="submit" value="Add Artist" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green hover:bg-green-dark block w-full py-4 text-white items-center justify-center" />
 -->
    </form>

    <hr class="border border-grey-light my-6" />

    <ul class="list-reset mt-4">
      <li class="py-4" v-for="company in companies" :key="company.id" :company="company">

        <div class="flex items-center justify-between flex-wrap">
          <p class="block flex-1 font-mono font-semibold flex items-center ">
            {{ company.attributes.name }}
          </p>

          <button class="bg-tranparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 mr-2 rounded"
          @click.prevent="editCompany(company)">Edit</button>

          <button class="bg-transprent text-sm hover:bg-red text-red hover:text-white no-underline font-bold py-2 px-4 rounded border border-red"
         @click.prevent="removeCompany(company)">Delete</button>
        </div>

        <div v-if="company == editedCompany">
          <form action="" @submit.prevent="updateCompany(company)">
            <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4">
              <input class="input" v-model="company.name" />
              <input type="submit" value="Update" class=" my-2 bg-transparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 rounded cursor-pointer">
            </div>
          </form>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Company',
  data () {
    return {
      companies: [],
      newCompany: [],
      error: '',
      editedCompany: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/companies')
        .then(response => { this.companies = response.data.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addCompany () {
      const value = this.newCompany
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/companies/', { company: { name: this.newCompany.name } })

        .then(response => {
          this.companies.push(response.data)
          this.newCompany = ''
        })
        .catch(error => this.setError(error, 'Cannot create company'))
    },
    removeCompany (company) {
      this.$http.secured.delete(`/api/v1/companies/${company.id}`)
        .then(response => {
          this.companies.splice(this.companies.indexOf(company), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete company'))
    },
    editCompany (company) {
      this.editedCompany = company
    },
    updateCompany (company) {
      this.editedCompany = ''
      this.$http.secured.patch(`/api/v1/companies/${company.id}`, { company: { name: company.name } })
        .catch(error => this.setError(error, 'Cannot update company'))
    }
  }
}
</script>
