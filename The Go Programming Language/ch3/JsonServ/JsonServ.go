/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-02
 * Time: 下午9:43
 */

package main

import "github.com/gin-gonic/gin"

func main() {
	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200,
			gin.H{
				"message": "HI",
				"name":    "Insomnia",
			})
	})

	r.Run(":8888")
}
