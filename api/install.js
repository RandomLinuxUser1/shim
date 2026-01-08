export default async function handler(req, res) {
  try {
    const ua = req.headers['user-agent'] || ''
    const isCLI = ua.includes('curl') || ua.includes('wget') || ua.includes('httpie')

    if (isCLI) {
      const response = await fetch('https://shim-csd.vercel.app/csd.sh')
      if (!response.ok) return res.status(500).send('Failed to fetch installer script')
      const text = await response.text()
      res.setHeader('Content-Type', 'text/plain')
      return res.status(200).send(text)
    }

    return res.redirect(302, '/index.html')

  } catch {
    return res.status(500).send('Internal Server Error')
  }
}
