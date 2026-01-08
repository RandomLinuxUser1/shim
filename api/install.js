export default async function handler(req, res) {
  const ua = req.headers.get('user-agent') || ''

  const isCLI = ua.includes('curl') || ua.includes('wget') || ua.includes('httpie')

  if (isCLI) {
    const scriptUrl = 'https://shim-csd.vercel.app/csd.sh'
    const response = await fetch(scriptUrl)
    const text = await response.text()

    res.setHeader('Content-Type', 'text/plain')
    res.status(200).send(text)
    return
  }
  res.redirect(302, '/index.html')
}
