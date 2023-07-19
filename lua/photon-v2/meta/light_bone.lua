if (exmeta.ReloadFile()) then return end

NAME = "PhotonLightBone"
BASE = "PhotonLight"

---@class PhotonLightBone : PhotonLight
---@field BoneId number
local Element = exmeta.New()

-- Rotation behaviors...
-- 1. Continuous
-- 2. Sweep
-- 3. Static
-- 4. User-defined (spotlights)?
--
-- wind up/down behavior


Element.Class = "Bone"

