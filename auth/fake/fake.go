package fake

import (
	"time"

	"github.com/vx3r/wg-gen-web/model"
	"github.com/vx3r/wg-gen-web/util"
	"golang.org/x/oauth2"
)

// Fake in order to implement interface, struct is required
type Fake struct{}

// Setup validate provider
func (o *Fake) Setup() error {
	return nil
}

//Check if current user is in given group
func (o *Fake) IsInGroup(oauth2Token *oauth2.Token, group string) (bool, error) {
	return true, nil
}

// CodeUrl get url to redirect client for auth
func (o *Fake) CodeUrl(state string) string {
	return "_magic_string_fake_auth_no_redirect_"
}

// Exchange exchange code for Oauth2 token
func (o *Fake) Exchange(code string) (*oauth2.Token, error) {
	rand, err := util.GenerateRandomString(32)
	if err != nil {
		return nil, err
	}

	return &oauth2.Token{
		AccessToken:  rand,
		TokenType:    "",
		RefreshToken: "",
		Expiry:       time.Time{},
	}, nil
}

// UserInfo get token user
func (o *Fake) UserInfo(oauth2Token *oauth2.Token) (*model.User, error) {
	return &model.User{
		Sub:      "unknown",
		Name:     "Unknown",
		Email:    "unknown",
		Issuer:   "unknown",
		IssuedAt: time.Time{},
	}, nil
}
