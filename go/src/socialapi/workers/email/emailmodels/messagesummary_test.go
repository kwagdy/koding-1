package emailmodels

import (
	"socialapi/workers/common/runner"
	"testing"
	"time"

	. "github.com/smartystreets/goconvey/convey"
)

func TestRenderMessage(t *testing.T) {
	r := runner.New("test")
	if err := r.Init(); err != nil {
		t.Fatalf("couldn't start bongo %s", err.Error())
	}
	defer r.Close()

	Convey("Message should be able to rendered", t, func() {
		ms := NewMessageSummary("canthefason", "", "hehe", time.Now())

		body, err := ms.Render()
		So(err, ShouldBeNil)
		So(body, ShouldContainSubstring, "canthefason:")
		So(body, ShouldContainSubstring, "hehe")
	})
}
