cask "eloston-chromium-signed" do
    arch arm: "arm64", intel: "x86-64"
  
    version "126.0.6478.182-1.1"
    sha256 arm:   "047fbbf8f7a7af7ddf8b515c036a99186eaaab605c2c5ff5e7176ef6373ddeda",
           intel: "c486ed20df50447896a8ab7e52a80e8281bb9909e017d066d54a20aaad048384"

    url "https://github.com/claudiodekker/ungoogled-chromium-macos/releases/download/#{version}/ungoogled-chromium_#{version}_#{arch}-macos-signed.dmg",
        verified: "github.com/claudiodekker/ungoogled-chromium-macos/"
    name "Ungoogled Chromium (Notarized)"
    desc "Google Chromium, sans integration with Google"
    homepage "https://ungoogled-software.github.io/"
  
    livecheck do
      url :url
      regex(/^v?(\d+(?:[.-]\d+)+)(?:[._-]#{arch})?(?:[._-]+?(\d+(?:\.\d+)*))?$/i)
      strategy :github_latest do |json, regex|
        match = json["tag_name"]&.match(regex)
        next if match.blank?
  
        match[1]
      end
    end
  
    conflicts_with cask: [
      "chromium",
      "freesmug-chromium",
      "eloston-chromium",
    ]
    depends_on macos: ">= :catalina"
  
    app "Chromium.app"
  
    zap trash: [
      "~/Library/Application Support/Chromium",
      "~/Library/Caches/Chromium",
      "~/Library/Preferences/org.chromium.Chromium.plist",
      "~/Library/Saved Application State/org.chromium.Chromium.savedState",
    ]
  end
