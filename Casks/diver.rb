# Written by Diver's release workflow on every release — an edit here is
# overwritten by the next one.
cask "diver" do
  version "1.0.0,468"
  sha256 "3e3a4df57ea3ac7497ab9dcc7e0d9bc2b62d6b8f4ff320b92fd759f9669c5c15"

  url "https://github.com/usediver/homebrew-diver/releases/download/v#{version.csv.first}-#{version.csv.second}/Diver-#{version.csv.first}-#{version.csv.second}.dmg"
  name "Diver"
  desc "Build, launch and document deeplinks"
  homepage "https://usediver.com/"

  # Tags are v<version>-<build>; the build alone moves on every release.
  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)-(\d+)$/i)
    strategy :github_latest do |json, regex|
      match = json["tag_name"]&.match(regex)
      next if match.blank?

      "#{match[1]},#{match[2]}"
    end
  end

  depends_on macos: ">= :monterey"

  app "Diver.app"

  zap trash: [
    "~/Documents/diver_db.sqlite*",
    "~/Library/Application Support/com.usediver.app",
    "~/Library/Caches/com.usediver.app",
    "~/Library/HTTPStorages/com.usediver.app",
    "~/Library/Preferences/com.usediver.app.plist",
    "~/Library/Saved Application State/com.usediver.app.savedState",
  ]
end
