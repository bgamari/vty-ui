-- |This module provides high-level composed widgets.
module Graphics.Vty.Widgets.Composed
    ( bottomPadded
    , topPadded
    , boxLimit
    )
where

import Graphics.Vty.Widgets.Rendering
    ( Widget
    , primaryAttribute
    )
import Graphics.Vty.Widgets.Base
    ( Box
    , VFill
    , VLimit
    , HLimit
    , (<-->)
    , vFill
    , vLimit
    , hLimit
    )

-- NOTE: these widgets are no longer correctly implemented, since now
-- the primary attribute of a child widget could change and these
-- widgets would never pick up on the state change because the vFill
-- primary attributes are chosen at widget construction time, not
-- dynamically based on the child widget state.

-- |Add expanding bottom padding to a widget.
bottomPadded :: Widget a -> Widget (Box a VFill)
bottomPadded w = w <--> vFill (primaryAttribute w) ' '

-- |Add expanding top padding to a widget.
topPadded :: Widget a -> Widget (Box VFill a)
topPadded w = vFill (primaryAttribute w) ' ' <--> w

-- |Impose a maximum size (width, height) on a widget.
boxLimit :: Int -- ^Maximum width in columns
         -> Int -- ^Maximum height in rows
         -> Widget a
         -> Widget (VLimit (HLimit a))
boxLimit maxWidth maxHeight = vLimit maxHeight . hLimit maxWidth