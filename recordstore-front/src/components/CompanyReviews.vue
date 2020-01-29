<template>
  <div class="max-w-md m-auto py-10">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4">Add a new review</h3>
    <form action="" @submit.prevent="addCompanyReview">
      <div class="mb-6">
        <label for="company_review_review" class="label">Review</label>
        <input
          id="record_title"
          class="input"
          autofocus autocomplete="off"
          placeholder="Type you review here"
          v-model="newCompanyReview.review" />
      </div>

      <div class="mb-6">
        <label for="record_year" class="label">Year</label>
        <input
          id="record_year"
          class="input"
          autofocus autocomplete="off"
          placeholder="Rating"
          v-model="newCompanyReview.rating"
        />
       </div>

      <div class="mb-6">
        <label for="сompany" class="label">Company</label>
        <select id="company" class="select" v-model="newCompanyReview.company">
          <option disabled value="">Select an Company</option>
          <option :value="company.id" v-for="company in companies" :key="company.id">{{ company.name }}</option>
        </select>
        <p class="pt-4">Don't see a company? <router-link class="text-grey-darker underline" to="/companies">Create one</router-link></p>
       </div>

      <input type="submit" value="Add Review" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green-500 hover:bg-green-700 block w-full py-4 text-white items-center justify-center" />
    </form>

    <hr class="border border-grey-light my-6" />

    <ul class="list-reset mt-4">
      <li class="py-4" v-for="companyReview in companyReviews" :key="companyReview.id" :companyReview="companyReview">

        <div class="flex items-center justify-between flex-wrap">
          <div class="flex-1 flex justify-between flex-wrap pr-4">
            <p class="block font-mono font-semibold flex items-center">
              <svg class="fill-current text-indigo w-6 h-6 mr-2" viewBox="0 0 24 24" width="24" height="24"><title>record vinyl</title><path d="M23.938 10.773a11.915 11.915 0 0 0-2.333-5.944 12.118 12.118 0 0 0-1.12-1.314A11.962 11.962 0 0 0 12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12c0-.414-.021-.823-.062-1.227zM12 16a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm0-5a1 1 0 1 0 0 2 1 1 0 0 0 0-2z" ></path></svg>
              {{ companyReview.review }} &mdash; {{ companyReview.rating }}
            </p>
            <p class="block font-mono font-semibold">{{ getCompany(companyReview) }}</p>
          </div>
          <button class="bg-transparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 mr-2 rounded"
          @click.prevent="editCompanyReview(companyReview)">Edit</button>

          <button class="bg-transparent text-sm hover:bg-red text-red hover:text-white no-underline font-bold py-2 px-4 rounded border border-red"
         @click.prevent="removeCompanyReview(companyReview)">Delete</button>
        </div>

        <div v-if="companyReview == editedCompanyReview">
          <form action="" @submit.prevent="updateCompanyReview(companyReview)">
            <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4">

              <div class="mb-6">
                <label class="label">Review</label>
                <input class="input" v-model="companyReview.review" />
              </div>

              <div class="mb-6">
                <label class="label">Year</label>
                <input class="input" v-model="companyReview.year" />
              </div>

              <div class="mb-6">
                <label class="label">Company</label>
                <select id="artist" class="select" v-model="companyReview.company">
                  <option :value="company.id" v-for="company in companies" :key="company.id">{{ company.name }}</option>
                </select>
              </div>

              <input type="submit" value="Update" class="bg-transparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 mr-2 rounded">
            </div>
          </form>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'CompanyReviews',
  data () {
    return {
      companies: [],
      companyReviews: [],
      newCompanyReview: [],
      error: '',
      editedCompanyReview: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/company_reviews')
        .then(response => { this.companyReviews = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))

      this.$http.secured.get('/api/v1/companies')
        .then(response => { this.companies = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    getCompany (companyReview) {
      const companyReviewCompanyValues = this.companies.filter(company => company.id === companyReview.company_id)
      let company

      companyReviewCompanyValues.forEach(function (element) {
        company = element.name
      })

      return company
    },
    addCompanyReview () {
      const value = this.newCompanyReview
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/company_reviews/', { company_review: { review: this.newCompanyReview.review, rating: this.newCompanyReview.rating, company_id: this.newCompanyReview.company } })

        .then(response => {
          this.companyReviews.push(response.data)
          this.newCompanyReview = ''
        })
        .catch(error => this.setError(error, 'Cannot create review'))
    },
    removeCompanyReview (companyReview) {
      this.$http.secured.delete(`/api/v1/company_reviews/${companyReview.id}`)
        .then(response => {
          this.companyReviews.splice(this.companyReview.indexOf(companyReview), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete review'))
    },
    editCompanyReviw (companyReview) {
      this.editedCompanyReview = companyReview
    },
    updateCompanyReview (companyReview) {
      this.editedCompanyReview = ''
      this.$http.secured.patch(`/api/v1/company_reviews/${companyReview.id}`, { companyReview: { review: companyReview.review, rating: companyReview.rating, company_id: companyReview.company } })
        .catch(error => this.setError(error, 'Cannot update review'))
    }
  }
}
</script>
