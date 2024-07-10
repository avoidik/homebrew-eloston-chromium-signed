cask "eloston-chromium" do
    arch arm: "arm64", intel: "x86-64"
  
    version "126.0.6478.61-1.1"
    sha256 arm:   "5a691f1db4789728bbea48eb54da99e803c0f6bdd5195229f9cc9a6e313a98c3",
           intel: "e1b6fa0a5c9064472cc508dd79ac004b5db6756260d4e7a52c179bd46b2a5fe7"

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